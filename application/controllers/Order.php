<?php
use chriskacerguis\RestServer\RestController; 
Class Order extends RestController{
    public function __construct(){
        header('Access-Control-Allow-Origin: *');
        header("Access-Control-Allow-Methods: GET, OPTIONS, POST, DELETE");
        header("Access-Control-Allow-Headers: Authorization, Content-Type, Content-Length, Accept-Encoding");
        parent::__construct();
        $this->load->model('OrderModel');
        $this->load->library('form_validation');
        $this->load->helper(['jwt','authorization']);
        $this->load->library('Pdf');
        include_once APPPATH . '/third_party/fpdf/fpdf.php';
    }

    public function index_get(){
        return $this->returnData($this->db->get('data_order')->result(), false);
    }

    public function userOrder_get($username){
        $data = $this->verify_request();
        $status = parent::HTTP_OK;
        if($data['status'] == 401){
            return $this->returnData($data['msg'],true);
        }
        return $this->returnData($this->db->get_where('data_order', ["username" => $username])->result(), false);
    }

    public function index_post($id = null){
        $validation = $this->form_validation;
        $rule = $this->OrderModel->rules();
        if($id == null){
            array_push($rule,[
                    'field' => 'address',
                    'label' => 'address',
                    'rules' => 'required'
                ],
                [
                    'field' => 'price_cat',
                    'label' => 'price_cat',
                    'rules' => 'required'
                ],
                [
                    'field' => 'weight',
                    'label' => 'weight',
                    'rules' => 'required|integer'
                ],
                [
                    'field' => 'status',
                    'label' => 'status',
                    'rules' => 'required'
                ]
            );
        }
        else{
            array_push($rule,
                [
                    'field' => 'address',
                    'label' => 'address',
                    'rules' => 'required'
                ],
                [
                    'field' => 'price_cat',
                    'label' => 'price_cat',
                    'rules' => 'required'
                ],
                [
                    'field' => 'weight',
                    'label' => 'weight',
                    'rules' => 'required|integer'
                ],
                [
                    'field' => 'status',
                    'label' => 'status',
                    'rules' => 'required'
                ]
            );
        }
        $validation->set_rules($rule);
		if (!$validation->run()) {
			return $this->returnData($this->form_validation->error_array(), true);
        }
        $order = new OrderData();
        $order->username = $this->post('username');
        $order->phone = $this->post('phone');
        $order->address = $this->post('address');
        $order->price_cat = $this->post('price_cat');
        $order->weight = $this->post('weight');
        $order->price = $this->post('price');
        $order->status = $this->post('status');
        if($id == null){
            $response = $this->OrderModel->store($order);
        }else{
            $response = $this->OrderModel->update($order,$id);
        }
        return $this->returnData($response['msg'], $response['error']);
    }

    public function index_delete($id = null){
        if($id == null){
			return $this->returnData('Parameter Id Tidak Ditemukan', true);
        }
        $response = $this->OrderModel->destroy($id);
        return $this->returnData($response['msg'], $response['error']);
    }

    public function returnData($msg,$error){
        $response['error']=$error;
        $response['message']=$msg;
        return $this->response($response);
    }

    private function verify_request()
    {
        // Get all the headers
        $headers = $this->input->request_headers();
        // Extract the token
        if(isset($headers['Authorization'])){
            $header = $headers['Authorization'];
        }else
        {
            $status = parent::HTTP_UNAUTHORIZED;
            $response = ['status' => $status, 'msg' => 'Unauthorized Access!'];
            return $response;
        }
        //Configure username git
        //$token = explode(".", $header)[1];
        // Use try-catch
        // JWT library throws exception if the token is not valid
        try {
            // Validate the token
            // Successfull validation will return the decoded user data else returns false
            $data = AUTHORIZATION::validateToken($header);
            if ($data === false) {
                $status = parent::HTTP_UNAUTHORIZED;
                $response = ['status' => $status, 'msg' => 'Unauthorized Access!'];
            } else {
                $response = ['status' => 200, 'msg' => $data];
            }
            return $response;
        } catch (Exception $e) {
            // Token is invalid
            // Send the unathorized access message
            $status = parent::HTTP_UNAUTHORIZED;
            $response = ['status' => $status, 'msg' => 'Unauthorized Access! '];
            //$this->response($response, $status);
            return $response;
        }
    }

    public function printInvoice_get($id = null){
        $data = $this->verify_request();
        $status = parent::HTTP_OK;
        if($data['status'] == 401){
            return $this->returnData($data['msg'],true);
        }

        $pdf = new FPDF('p','mm','A4');
        // membuat halaman baru
        $pdf->AddPage();
    
        // $dataTransaksi = null;
        // $dataDetailTransaksi = null;
        $order_data = null;
        $user_data = null;
        $price_cat_data = null;

        $resultOrder = $this->db->get_where('data_order', ["id" => $id]);

        if($resultOrder->num_rows()!=0){
            $order_data = $resultOrder->row();
            $resultUser = $this->db->get_where('data_user', ["username" => $order_data->username]);
            $resultPrice = $this->db->get_where('data_pricelist', ["category" => $order_data->price_cat]);
            if($resultUser->num_rows()!=0){
                $user_data = $resultUser->row();
            }
            if($resultPrice->num_rows()!=0){
                $price_cat_data = $resultPrice->row();
            }
        }else{
            $this->returnData("ID Order not found!",true);
        }

        $created_at = date("j",strtotime($order_data->created_at))." ".
                            date("F",strtotime($order_data->created_at))." ".
                            date("Y",strtotime($order_data->created_at));
        $printed_at = date("j")." ".date("F")." ".date("Y");

        $pdf->Image(APPPATH.'controllers/InvoiceHeader/CleanFreshLaundryHeader.png',10,10,-235);
        $pdf->Cell(10,50,'',0,1);// Memberikan space kebawah agar tidak terlalu rapat
        $pdf->Cell(70);
        $pdf->SetFont('Arial','B',14);
        $pdf->Cell(50,7,'Laundry Order Invoice',0,1,'C');
        $pdf->SetFont('Arial','B',10);
        $pdf->Cell(190,8,'Invoice ID : '.$order_data->id,0,1, 'R');
        $pdf->Cell(190,8,'Created At : '.$created_at,0,0, 'R');
        $pdf->SetFont('Arial','B',10);
        $pdf->Cell(10,10,'',0,1);
        $pdf->Cell(45,6,'Member Data',0,1);
        $pdf->SetFont('Arial','',10);
        if($user_data!=null){
            $pdf->Cell(45,6,'Name  ',0,0);
            $pdf->Cell(45,6,':  '.$user_data->name,0,1);
            $pdf->Cell(45,6,'Phone ',0,0);
            $pdf->Cell(45,6,':  '.$user_data->phone,0,1);
            $pdf->Cell(45,6,'Email  ',0,0);
            $pdf->Cell(45,6,':  '.$user_data->email,0,1);
        }
        $pdf->Cell(45,6,'Username  ',0,0);
        $pdf->Cell(45,6,':  '.$order_data->username,0,1);
        $pdf->Cell(45,6,'Address  ',0,0);
        $pdf->Cell(45,6,':  '.$order_data->address,0,1);
        $pdf->Cell(10,10,'',0,1);
        //$pdf->Cell(70,10);
        $pdf->SetFont('Arial','B',12);
        $pdf->Cell(50,7,'Your Order',0,1,'C');
        $pdf->Cell(190,7,'_______________________________________________________________________________',0,1,'C');
        $pdf->Cell(10,5,'',0,1);
        $pdf->SetFont('Arial','B',10);
        $pdf->Cell(60,6,'Price Category',1,0,'C');
        if($price_cat_data!=null){
            $pdf->Cell(30,6,'Duration (day)',1,0,'C');
            $pdf->Cell(35,6,'Price/kg',1,0,'C');
        }
        $pdf->Cell(25,6,'Weight (kg)',1,0,'C');
        $pdf->Cell(40,6,'Total Price',1,1,'C');
        $pdf->SetFont('Arial','',10);    

        $pdf->Cell(60,10,$order_data->price_cat,1,0,'L');
        if($price_cat_data!=null){
            $pdf->Cell(30,10,$price_cat_data->duration,1,0,'C');
            $pdf->Cell(35,10,'Rp. '.$price_cat_data->price,1,0,'C');
        }
        $pdf->Cell(25,10,$order_data->weight,1,0,'C');
        $pdf->Cell(40,10,'Rp. '.$order_data->price,1,1,'C');

        $pdf->Cell(10,10,'',0,1);
        $pdf->SetFont('Arial','B',12);
        $pdf->Cell(190,7,'Thanks you for your order, we will wait for your next order',0,1,'C');
        $pdf->Cell(10,20,'',0,1);
        $pdf->SetFont('Arial','B',10);
        $pdf->Cell(190,7,'Printed at '.$printed_at,0,1,'R');
        $pdf->Output('CleanFreshLaundryInvoice'.$order_data->id.'.pdf','D');
    }
}

Class OrderData{
    public $username;
    public $phone;
    public $address;
    public $price_cat;
    public $weight;
    public $price;
    public $status;
}