package com.ariaramin.monito.Adapters

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.View.GONE
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.RelativeLayout
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.ariaramin.monito.R
import com.ariaramin.monito.Models.Transaction

class TransactionAdapter(var context: Context) : RecyclerView.Adapter<TransactionAdapter.TransactionViewHolder>() {

    private var transactions: MutableList<Transaction> = ArrayList()

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): TransactionViewHolder {
        val view = LayoutInflater.from(context).inflate(R.layout.transaction_item, parent, false)
        return TransactionViewHolder(view)
    }

    override fun onBindViewHolder(holder: TransactionViewHolder, position: Int) {
        holder.bindData(transactions[position])
    }

    override fun getItemCount(): Int {
        return transactions.size
    }

    fun addItem(transaction: Transaction) {
        transactions.add(0, transaction)
        notifyItemInserted(0)
    }

    fun addItemList(transactionList: List<Transaction>) {
        transactions.addAll(transactionList)
        notifyDataSetChanged()
    }


    class TransactionViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        val headerRelativeLayout = itemView.findViewById<RelativeLayout>(R.id.headerRelativeLayout)
        val dateTextView = itemView.findViewById<TextView>(R.id.dateTextView)
        val totalTextView = itemView.findViewById<TextView>(R.id.totalTextView)
        val categoryImageView = itemView.findViewById<ImageView>(R.id.categoryImageView)
        val titleTextView = itemView.findViewById<TextView>(R.id.categoryTitleTextView)
        val noteTextView = itemView.findViewById<TextView>(R.id.noteTextView)
        val amountTextView = itemView.findViewById<TextView>(R.id.amountTextView)

        fun bindData(transaction: Transaction) {
            dateTextView.text = transaction.date
            totalTextView.text = transaction.amount.toString()
//            categoryImageView.setImageBitmap(transaction.category.image)
//            titleTextView.text = transaction.category.title
            if (transaction.note.isNotEmpty()) {
                noteTextView.text = transaction.note
            } else {
                noteTextView.visibility = GONE
            }
            amountTextView.text = transaction.amount.toString()
        }
    }
}