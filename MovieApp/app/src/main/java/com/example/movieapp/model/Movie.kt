package com.example.movieapp.model

import android.os.Parcelable
import kotlinx.parcelize.Parcelize
import java.io.Serializable
@Parcelize
data class Movie(
    val id: Int,
    val title: String,
    val overview: String,
    val poster_path: String
):Parcelable

