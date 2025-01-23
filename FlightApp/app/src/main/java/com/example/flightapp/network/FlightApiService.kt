package com.example.flightapp.network

import com.example.flightapp.model.FlightResponse
import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Query

interface FlightApiService {
    @GET("airlines")
    fun getFlights(
        @Query("access_key")apiKey:String
    ): Call<FlightResponse>
}