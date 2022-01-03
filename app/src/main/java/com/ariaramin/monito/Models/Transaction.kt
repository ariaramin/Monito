package com.ariaramin.monito.Models

import androidx.annotation.Nullable
import androidx.room.Entity
import androidx.room.ForeignKey
import androidx.room.PrimaryKey

@Entity(
    tableName = "transaction_tbl",
    foreignKeys = [ForeignKey(
        entity = Category::class,
        parentColumns = ["id"],
        childColumns = ["categoryId"],
        onDelete = ForeignKey.CASCADE
    )]
)
data class Transaction(
    var categoryId: Long,
    @Nullable
    var note: String,
    var amount: String,
    var date: String
) {
    @PrimaryKey(autoGenerate = true)
    var id: Long? = null
}