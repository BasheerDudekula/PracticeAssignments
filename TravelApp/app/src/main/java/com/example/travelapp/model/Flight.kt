package com.example.travelapp.model

import android.os.Parcelable
import kotlinx.parcelize.Parcelize

@Parcelize
data class Flight(
    val flightId: Int,
    val flightName: String,
    val flightStatus: String,
    val flightDetails: String
) : Parcelable