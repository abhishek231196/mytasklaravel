<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\ProjectMaster;
use Validator;
use App\Models\TransactionHistory;
use DB;
class ProjectTranscation extends Controller
{
    public function index()
    {
        $Project = ProjectMaster::with('transcations')->get();
        
        $final=[
            "status"=>true,
            "data"=>$Project,
            "message"=>"Project Wise tanscation"
        ];
        return response()->json($final,200);
    }
    public function savetransaction(Request $request)
    {
        $rules = [
            'project_id'=>'required',
            'from_account_no'=>'required',
            'to_account_no'=>'required',
            'transaction_amount'=>'required',
            'transaction_date'=>'required',
        ];
        $validater = Validator::make($request->all(),$rules);
        if($validater->fails()){
            return response()->json(implode(',',$validater->errors()->all()),200);
        }
        $lastrecord = TransactionHistory::select('closing_balance')->where('payment_status','A')->orderBy('id','desc')->first();
        $openingbalance=0;
        if($lastrecord)
        {
            $openingbalance=$lastrecord->closing_balance;
        }
        
        $History = new TransactionHistory();
        $History->project_id = $request->project_id;
        $History->from_account_no = $request->from_account_no;
        $History->to_account_no = $request->to_account_no;
        $History->transaction_amount = $request->transaction_amount;
        $History->transaction_date = date('Y-m-d',strtotime($request->transaction_date));
        $History->opening_balance = $openingbalance; 
        $History->closing_balance=$openingbalance;
        $History->payment_status='P';
        $History->save();

        $final=[
            "status"=>true,
            "data"=>[],
            "message"=>"Transaction Saved"
        ];
        return response()->json($final,200);

    }
    public function update($id,Request $request)
    {
        $rules = [
            'status'=>'required',
        ];
        $validater = Validator::make($request->all(),$rules);
        if($validater->fails()){
            return response()->json(implode(',',$validater->errors()->all()),200);
        }
        $th= TransactionHistory::find($id);
        if($th)
        {
            $th->payment_status = $request->status;
            
            if($request->status =='A')
            {
                $amount=$th->transaction_amount;
                $openingbalance=$th->opening_balance;
                $closingbalance=$openingbalance + $amount;
                $th->closing_balance=$closingbalance;
                $th->update();
                $alltranscaion = TransactionHistory::where('id' ,'>', $id)->get();
                
                $openingBalance = $closingbalance;
                foreach ($alltranscaion as $value) {
                    $value->opening_balance =$openingBalance;
                    if($value->payment_status =='A')
                    {
                        $value->closing_balance =$value->transaction_amount + $openingBalance;
                        $openingBalance = $value->closing_balance;
                    }
                    else
                    {
                        $openingBalance = $openingBalance;
                    }
                    $value->save();
                }
            }
            
            

        }
        $final=[
            "status"=>true,
            "data"=>[],
            "message"=>"Transaction Status changed"
        ];
        return response()->json($final,200);
        
    }
    public function analytics($id)
    {
        
        $data = DB::table('project_masters')
        ->select('project_masters.name', 'project_masters.booking_amount AS total_booking_amount', DB::raw("SUM(transaction_histories.transaction_amount) as received_amount"))
        ->join('transaction_histories','project_masters.id','=','transaction_histories.project_id')
        ->where('transaction_histories.payment_status','=','A')
        ->where('project_masters.id','=',$id)
        ->groupBy('transaction_histories.project_id')
        ->first();
        if($data)
        {
            $final=[
                "status"=>true,
                "data"=>[
                    'projectname'=>$data->name,
                    'total_booking_amount'=>$data->total_booking_amount,
                    'received_amount'=>$data->received_amount,
                    'receivable_amount'=>($data->total_booking_amount - $data->received_amount),
                ],
                "message"=>"Transaction Status changed"
            ];
            return response()->json($final,200);
        }
        
    }
}
