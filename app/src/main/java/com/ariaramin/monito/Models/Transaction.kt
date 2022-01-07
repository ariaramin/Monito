package com.ariaramin.monito.Models

import androidx.annotation.Nullable
import androidx.room.Embedded
import androidx.room.Entity
import androidx.room.ForeignKey
import androidx.room.PrimaryKey

@Entity(tableName = "transaction_tbl")
data class Transaction(
    @Embedded
    var category: Category,
    @Nullable
    var note: String,
    var amount: String,
    var date: String
) {
    @PrimaryKey(autoGenerate = true)
    var transactionId: Long? = null
}