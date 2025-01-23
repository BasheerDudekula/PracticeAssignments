package com.example.flightapp.model

import android.os.Parcelable
import kotlinx.parcelize.Parcelize

@Parcelize
data class Flight( val airline_name:String,
                   val country_name:String,
                   val iata_code:String):Parcelable
