package com.example.userapp_remoteapi.network

import com.example.userapp_remoteapi.model.Todo
import com.example.userapp_remoteapi.model.User
import retrofit2.Call
import retrofit2.http.GET

interface ApiService {
    @GET("users")
    fun getUsers(): Call<List<User>>
    @GET("todos")
    fun getTodos(): Call<List<Todo>>

}