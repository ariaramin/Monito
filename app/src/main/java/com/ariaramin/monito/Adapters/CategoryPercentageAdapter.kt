package com.ariaramin.monito.Adapters

import android.content.res.ColorStateList
import android.os.Build
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.ProgressBar
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.ariaramin.monito.Models.Category
import com.ariaramin.monito.Models.Entry
import com.ariaramin.monito.Models.Transaction
import com.ariaramin.monito.R
import com.ariaramin.monito.Utils.Utils

class CategoryPercentageAdapter :
    RecyclerView.Adapter<CategoryPercentageAdapter.CategoryPercentageViewHolder>() {

    private val transactionList = ArrayList<Transaction>()
    private val colorList = ArrayList<Int>()
    private val entryList = ArrayList<Entry>()

    override fun onCreateViewHolder(
        parent: ViewGroup,
        viewType: Int
    ): CategoryPercentageViewHolder {
        val view = LayoutInflater.from(parent.context)
            .inflate(R.layout.category_percentage_layout, parent, false)
        return CategoryPercentageViewHolder(view)
    }

    override fun onBindViewHolder(holder: CategoryPercentageViewHolder, position: Int) {
        holder.bindDate(
            entryList[position].category,
            entryList[position].percentage,
            colorList[position]
        )
    }


    override fun getItemCount(): Int {
        return entryList.size
    }

    fun addColorList(colors: List<Int>) {
        colorList.addAll(colors)
    }

    fun addTransactionList(transactions: List<Transaction>) {
        transactionList.addAll(transactions)
    }

    fun addCategoryHashMap(hashMap: HashMap<Category, String>) {
        entryList.clear()
        for (category in hashMap.keys) {
            if (hashMap[category]!!.toInt() != 0) {
                entryList.add(Entry(hashMap[category]!!.toInt(), category))
            }
        }
        notifyDataSetChanged()
    }

    inner class CategoryPercentageViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {

        val categoryImageView = itemView.findViewById<ImageView>(R.id.categoryPercentageImageView)
        val categoryTitleTextView =
            itemView.findViewById<TextView>(R.id.categoryPercentageTitleTextView)
        val categoryTotalTextView =
            itemView.findViewById<TextView>(R.id.categoryTotalTextView)
        val percentageProgressBar = itemView.findViewById<ProgressBar>(R.id.percentageProgressBar)

        fun bindDate(category: Category, percentage: Int, color: Int) {
            val utils = Utils()
            var total = 0
            val transactions =
                transactionList.filter { transaction -> transaction.category.categoryid == category.categoryid }
            for (transaction in transactions) {
                if (transaction.category.type == "income")
                    total += transaction.amount.toInt() else
                    total -= transaction.amount.toInt()
            }
            categoryTitleTextView.text = category.title
            categoryTotalTextView.text = utils.convertPersianPrice(total.toString())
            categoryImageView.setImageBitmap(category.image)
            percentageProgressBar.progress = percentage
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                percentageProgressBar.progressTintList = ColorStateList.valueOf(color)
            }
        }
    }
}