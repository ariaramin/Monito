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
    @PrimaryKey(autoGenerate = true)
    val id: Long,
    val categoryId: Long,
    @Nullable
    val note: String,
    val amount: Long,
    val date: String
)