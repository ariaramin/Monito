package com.ariaramin.monito.Adapters

import android.content.res.ColorStateList
import android.graphics.Color
import android.os.Build
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.ProgressBar
import android.widget.TextView
import androidx.annotation.RequiresApi
import androidx.recyclerview.widget.RecyclerView
import com.ariaramin.monito.Models.Category
import com.ariaramin.monito.Models.Transaction
import com.ariaramin.monito.R
import com.ariaramin.monito.Utils.Utils

class CategoryPercentageAdapter :
    RecyclerView.Adapter<CategoryPercentageAdapter.CategoryPercentageViewHolder>() {

    private val categoryList = ArrayList<Category>()
    private val transactionList = ArrayList<Transaction>()
    private var categoryHashMap: HashMap<Category, String>? = null

    override fun onCreateViewHolder(
        parent: ViewGroup,
        viewType: Int
    ): CategoryPercentageViewHolder {
        val view = LayoutInflater.from(parent.context)
            .inflate(R.layout.category_percentage_layout, parent, false)
        return CategoryPercentageViewHolder(view)
    }

    override fun onBindViewHolder(holder: CategoryPercentageViewHolder, position: Int) {
        val percentage = categoryHashMap!![categoryList[position]]
        holder.bindDate(categoryList[position], percentage!!.toInt())
    }

    override fun getItemCount(): Int {
        return categoryList.size
    }

    fun addTransactionList(transactions: List<Transaction>) {
        transactionList.addAll(transactions)
    }

    fun addCategoryHashMap(hashMap: HashMap<Category, String>) {
        categoryHashMap = hashMap
        for (category in hashMap.keys) {
            if (hashMap[category]!!.toInt() != 0) {
                categoryList.add(category)
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

        fun bindDate(category: Category, percentage: Int) {
            val utils = Utils()
            var total = 0
            val transactions =
                transactionList.filter { transaction -> transaction.category.categoryid == category.categoryid }
            for (transaction in transactions) {
                total -= transaction.amount.toInt()
            }
            categoryTitleTextView.text = category.title
            categoryTotalTextView.text = utils.convertPersianPrice(total.toString())
            categoryImageView.setImageBitmap(category.image)
            percentageProgressBar.progress = percentage
//            percentageProgressBar.progressTintList = ColorStateList.valueOf(getRandomColor())
        }

//        private fun getRandomColor(): Int {
//            val colors = itemView.resources.obtainTypedArray(R.array.material_colors)
//            val index = (Math.random() * colors.length()).toInt()
//            return colors.getColor(index, Color.BLACK)
//        }
    }
}