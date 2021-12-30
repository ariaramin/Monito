package com.ariaramin.monito.Database

import androidx.room.Entity

@Entity(tableName = "transaction_tbl")
data class Transaction(val id: Long,
                       val title: String) {

}