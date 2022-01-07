package com.ariaramin.monito.Adapters

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.View.GONE
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.ariaramin.monito.Models.Transaction
import com.ariaramin.monito.R
import com.ariaramin.monito.Utils.Utils


class TransactionAdapter(var context: Context) : RecyclerView.Adapter<TransactionAdapter.TransactionViewHolder>() {

    private var transactions: MutableList<Transaction> = ArrayList()

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): TransactionViewHolder {
        val inflater = LayoutInflater.from(context).inflate(R.layout.transaction_item, parent, false)
        return TransactionViewHolder(inflater)
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
        val categoryImageView = itemView.findViewById<ImageView>(R.id.transactionCategoryImageView)
        val titleTextView = itemView.findViewById<TextView>(R.id.categoryTitleTextView)
        val noteTextView = itemView.findViewById<TextView>(R.id.noteTextView)
        val amountTextView = itemView.findViewById<TextView>(R.id.amountTextView)

        fun bindData(transaction: Transaction) {
            val utils = Utils()
            categoryImageView.setImageBitmap(transaction.category.image)
            titleTextView.text = transaction.category.title
            if (transaction.note.isNotEmpty()) {
                noteTextView.text = transaction.note
            } else {
                noteTextView.visibility = GONE
            }
            if(transaction.category.type == "income") {
                amountTextView.text = "${utils.convertPersianPrice(transaction.amount)}+"
            } else {
                amountTextView.text = "${utils.convertPersianPrice(transaction.amount)}-"
            }
        }
    }
}