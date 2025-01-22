package com.example.photosapp.network

import com.example.photosapp.model.Photo
import retrofit2.Call
import retrofit2.http.GET

interface ApiService {
    @GET("photos")
    fun getPhotos(): Call<List<Photo>>
}