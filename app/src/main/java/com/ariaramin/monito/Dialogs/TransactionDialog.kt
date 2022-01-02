package com.ariaramin.monito.Dialogs

import android.app.Dialog
import android.os.Bundle
import androidx.fragment.app.DialogFragment
import android.app.AlertDialog
import android.view.LayoutInflater
import android.widget.Button
import com.ariaramin.monito.R
import com.ariaramin.monito.Utils.Utils
import com.ariaramin.monito.ViewModels.TransactionViewModel
import com.google.android.material.chip.Chip
import com.google.android.material.textfield.TextInputEditText
import com.google.android.material.textfield.TextInputLayout
import ir.hamsaa.persiandatepicker.PersianDatePickerDialog
import ir.hamsaa.persiandatepicker.api.PersianPickerDate
import ir.hamsaa.persiandatepicker.api.PersianPickerListener
import saman.zamani.persiandate.PersianDateFormat

import saman.zamani.persiandate.PersianDate


class TransactionDialog() : DialogFragment() {

    private lateinit var viewModel: TransactionViewModel
    private var dateChip: Chip? = null

    override fun onCreateDialog(savedInstanceState: Bundle?): Dialog {
        val builder = AlertDialog.Builder(activity)
        val view = LayoutInflater.from(activity).inflate(R.layout.transaction_dialog, null, false)
        val amountEditTextLayout =
            view.findViewById<TextInputLayout>(R.id.amountDialogEditTextLayout)
        val amountEditText = view.findViewById<TextInputEditText>(R.id.amountDialogEditText)
        val noteEditTextLayout = view.findViewById<TextInputLayout>(R.id.noteDialogEditTextLayout)
        val noteEditText = view.findViewById<TextInputEditText>(R.id.noteDialogEditText)
        dateChip = view.findViewById<Chip>(R.id.dateChip)
        dateChip!!.setOnClickListener {
            showDatePicker()
        }
        val categoryChip = view.findViewById<Chip>(R.id.categoryChip)
        categoryChip.setOnClickListener {
            val bottomSheet = CategoriesBottomSheet()
            bottomSheet.show(parentFragmentManager, bottomSheet.tag)
        }
        val saveTransactionButton = view.findViewById<Button>(R.id.saveTransactionButton)
        saveTransactionButton.setOnClickListener {
            if (amountEditText.length() > 0) {

            } else {
                amountEditTextLayout.error = resources.getString(R.string.empty_field_error)
            }
        }
        setCurrentDate()
        builder.setView(view)
        return builder.create()
    }


    private fun setCurrentDate() {
        val persianDate = PersianDate()
        val dateFormat = PersianDateFormat("Y-m-j")
        val longDateFormat =
            PersianDateFormat("j F Y", PersianDateFormat.PersianDateNumberCharacter.FARSI)
        dateChip!!.tag = dateFormat.format(persianDate)
        dateChip!!.text = longDateFormat.format(persianDate)
    }

    private fun showDatePicker() {
        val picker = PersianDatePickerDialog(activity)
            .setPositiveButtonString(resources.getString(R.string.ok))
            .setNegativeButton(resources.getString(R.string.cancel))
            .setTodayButton(resources.getString(R.string.today))
            .setActionTextColorResource(R.color.secondaryColor)
            .setAllButtonsTextSize(16)
            .setTodayButtonVisible(true)
            .setMinYear(1300)
            .setMaxYear(1500)
            .setMaxMonth(12)
            .setMaxDay(31)
            .setInitDate(
                PersianDatePickerDialog.THIS_YEAR,
                PersianDatePickerDialog.THIS_MONTH,
                PersianDatePickerDialog.THIS_DAY
            )
            .setTitleType(PersianDatePickerDialog.WEEKDAY_DAY_MONTH_YEAR)
            .setShowInBottomSheet(true)
            .setListener(object : PersianPickerListener {
                override fun onDateSelected(persianPickerDate: PersianPickerDate?) {
                    val utils = Utils()
                    val year = persianPickerDate!!.persianYear
                    val month =
                        if (persianPickerDate.persianMonth < 10) "0${persianPickerDate.persianMonth}" else persianPickerDate.persianMonth
                    val monthName = persianPickerDate.persianMonthName
                    val day = persianPickerDate.persianDay
                    val date = "${year}-${month}-${day}"
                    dateChip!!.tag = date
                    val longDate = "${utils.convertPersianNumber(day.toString())} $monthName ${
                        utils.convertPersianNumber(year.toString())
                    }"
                    dateChip!!.text = longDate
                }

                override fun onDismissed() {

                }
            })
        picker.show()
    }


}