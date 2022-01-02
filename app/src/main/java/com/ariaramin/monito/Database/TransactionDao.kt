package com.ariaramin.monito.Database

import androidx.lifecycle.LiveData
import androidx.room.Dao
import androidx.room.Insert
import androidx.room.Query
import androidx.room.Update
import androidx.room.Delete
import com.ariaramin.monito.Models.Transaction

@Dao
interface TransactionDao {

    @Insert
    fun addTransaction(transaction: Transaction): Long

    @Query("SELECT * FROM transaction_tbl")
    fun getALlTransactions(): LiveData<List<Transaction>>

    @Update
    fun updateTransaction(transaction: Transaction): Int

    @Delete
    fun deleteTransaction(transaction: Transaction): Int
}