package com.ariaramin.monito.ui.activities

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.ImageView
import android.widget.TextView
import androidx.lifecycle.ViewModelProvider
import com.ariaramin.monito.Database.AppDatabase
import com.ariaramin.monito.Models.Transaction
import com.ariaramin.monito.R
import com.ariaramin.monito.Repositories.TransactionRepository
import com.ariaramin.monito.Utils.Utils
import com.ariaramin.monito.ViewModels.TransactionViewModel
import com.ariaramin.monito.ViewModels.TransactionViewModelFactory

class TransactionActionActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_transaction_action)

        val categoryImageView = findViewById<ImageView>(R.id.detailCategoryImageView)
        val categoryTextView = findViewById<TextView>(R.id.detailCategoryTextView)
        val amountTextView = findViewById<TextView>(R.id.detailAmountTextView)
        val dateTextView = findViewById<TextView>(R.id.detailDateTextView)
        val noteTextView = findViewById<TextView>(R.id.detailNoteTextView)
        val editButton = findViewById<Button>(R.id.editButton)
        val deleteButton = findViewById<Button>(R.id.deleteButton)

        val backToHome = findViewById<ImageView>(R.id.backImageView5)
        backToHome.setOnClickListener {
            finish()
        }

        val database = AppDatabase.getInstance(applicationContext)
        val transactionRepository = TransactionRepository(database)
        val transactionFactory = TransactionViewModelFactory(transactionRepository)
        val viewModel =
            ViewModelProvider(this, transactionFactory).get(TransactionViewModel::class.java)

        val extra = intent.extras
        val transaction = extra!!.getParcelable<Transaction>("transaction")
        val utils = Utils()
        categoryImageView.setImageBitmap(transaction!!.category.image)
        categoryTextView.text = transaction.category.title
        amountTextView.text = utils.convertPersianPrice(transaction.amount)
        dateTextView.text = utils.convertLongDate(transaction.date)
        noteTextView.text = transaction.note

        editButton.setOnClickListener {
            val intent = Intent(this, TransactionActivity::class.java)
            val bundle = Bundle()
            bundle.putInt("status", 2)
            bundle.putParcelable("transaction", transaction)
            intent.putExtras(bundle)
            startActivity(intent)
            finish()
        }

        deleteButton.setOnClickListener {
            viewModel.deleteTransaction(transaction)
            finish()
        }
    }
}