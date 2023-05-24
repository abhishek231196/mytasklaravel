<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TransactionHistory extends Model
{
    public function projects()
    {
        return $this->belongsTo(ProjectMaster::class, 'project_id', 'id');
    }
}
