package com.ariaramin.monito.Database

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase

@Database(version = 1, entities = [Transaction::class])
abstract class AppDatabase : RoomDatabase() {
    private var appDatabase: AppDatabase? = null

    fun getInstance(context: Context): AppDatabase {
        if (appDatabase == null) {
            appDatabase = Room.databaseBuilder(
                context.applicationContext,
                AppDatabase::class.java,
                "db_transactions"
            )
            .allowMainThreadQueries()
            .fallbackToDestructiveMigration()
            .build()
        }
        return appDatabase!!
    }
}