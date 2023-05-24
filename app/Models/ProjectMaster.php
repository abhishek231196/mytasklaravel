<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProjectMaster extends Model
{
    use HasFactory;

    public function transcations()
    {
        return $this->hasMany(TransactionHistory::class,'project_id','id');
    }
}
