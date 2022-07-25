package com.ariaramin.monito.sharedPreferences

import android.content.Context
import com.ariaramin.monito.utils.Constants

class SharedPreferencesManager(private val context: Context) {

    fun setOnBoardingStatus(status: Boolean) {
        val preferences = context.getSharedPreferences(Constants.ON_BOARDING, Context.MODE_PRIVATE)
        val editor = preferences.edit()
        editor.putBoolean(Constants.FINISHED, status)
        editor.apply()
    }

    fun getOnBoardingStatus(): Boolean {
        val preferences = context.getSharedPreferences(Constants.ON_BOARDING, Context.MODE_PRIVATE)
        return preferences.getBoolean(Constants.FINISHED, false)
    }
}