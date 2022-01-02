package com.ariaramin.monito.Database

import androidx.lifecycle.LiveData
import androidx.room.Dao
import androidx.room.Insert
import androidx.room.Query
import com.ariaramin.monito.Models.Category

@Dao
interface CategoryDao {

    @Insert
    fun addCategory(category: Category): Long

    @Query("SELECT * FROM category_tbl WHERE type = 'income'")
    fun getIncomeCategories(): LiveData<List<Category>>

    @Query("SELECT * FROM category_tbl WHERE type = 'expense'")
    fun getExpenseCategories(): LiveData<List<Category>>
}