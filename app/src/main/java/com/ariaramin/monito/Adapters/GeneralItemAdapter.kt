package com.ariaramin.monito.Adapters

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.DividerItemDecoration
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.ariaramin.monito.Models.GeneralItem
import com.ariaramin.monito.Models.Transaction
import com.ariaramin.monito.R
import com.ariaramin.monito.Utils.Utils

class GeneralItemAdapter(var context: Context) : RecyclerView.Adapter<GeneralItemAdapter.GeneralItemViewHolder>() {

    private var generalItemList: MutableList<GeneralItem> = ArrayList()

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): GeneralItemViewHolder {
        val inflater = LayoutInflater.from(context).inflate(R.layout.date_item, parent, false)
        return GeneralItemViewHolder(inflater)
    }

    override fun onBindViewHolder(holder: GeneralItemViewHolder, position: Int) {
        holder.bindData(generalItemList[position])
    }

    override fun getItemCount(): Int {
        return generalItemList.size
    }

    fun addItemList(generalItems: List<GeneralItem>) {
        generalItemList.clear()
        generalItemList.addAll(generalItems)
        notifyDataSetChanged()
    }

    class GeneralItemViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        val dateTextView = itemView.findViewById<TextView>(R.id.dateTextView)
        val totalTextView = itemView.findViewById<TextView>(R.id.totalTextView)
        val transactionRecyclerView = itemView.findViewById<RecyclerView>(R.id.transactionItemRecyclerView)

        fun bindData(generalItem: GeneralItem) {
            val utils = Utils()
            dateTextView.text = utils.convertLongDate(generalItem.dateItem.date)
            totalTextView.text = utils.convertPersianPrice(generalItem.dateItem.total)
            val transactionAdapter = TransactionAdapter(itemView.context)
            val layoutManager = LinearLayoutManager(itemView.context)
            val dividerItemDecoration = DividerItemDecoration(itemView.context, layoutManager.orientation)
            transactionRecyclerView.layoutManager = layoutManager
            transactionRecyclerView.addItemDecoration(dividerItemDecoration)
            transactionRecyclerView.adapter = transactionAdapter
            transactionAdapter.addItemList(generalItem.transactionList)
        }
    }

}