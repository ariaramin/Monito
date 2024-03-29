package com.ariaramin.monito.Repositories

import androidx.lifecycle.LiveData
import com.ariaramin.monito.Database.AppDatabase
import com.ariaramin.monito.Models.Transaction

class TransactionRepository(private val db: AppDatabase) {

    fun insertTransaction(transaction: Transaction) {
        db.getTransactionDao().addTransaction(transaction)
    }

    fun getAllTransaction() : LiveData<List<Transaction>> {
        return db.getTransactionDao().getALlTransactions()
    }

    fun updateTransaction(transaction: Transaction) {
        db.getTransactionDao().updateTransaction(transaction)
    }

    fun deleteTransaction(transaction: Transaction) {
        db.getTransactionDao().deleteTransaction(transaction)
    }
}