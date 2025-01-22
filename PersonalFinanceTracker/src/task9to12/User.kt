package task9to12

data class User(val id: Int, val name: String, val email: String)

class UserManager{
    private val users: MutableList<User> = mutableListOf()

    // Add a new user
    fun addUser(user: User): Boolean {
        return if (users.any { it.id == user.id }) {
            println("User with ID ${user.id} already exists.")
            false
        } else {
            users.add(user)
            println("User added: $user")
            true
        }
    }

    // Remove a user by ID
    fun removeUserById(id: Int): Boolean {
        val userToRemove = users.find { it.id == id }
        return if (userToRemove != null) {
            users.remove(userToRemove)
            println("User removed: $userToRemove")
            true
        } else {
            println("User with ID $id not found.")
            false
        }
    }

    // Get all users
    fun getAllUsers(): List<User> {
        return users.toList() // Returns an immutable copy of the list
    }

    // Find a user by email
    fun findUserByEmail(email: String): User? {
        return users.find { it.email == email }
    }
}

fun main() {
    val userManager = UserManager()

    userManager.addUser(User(1, "Ajay", "ajay@gmail.com"))
    userManager.addUser(User(2, "Balu", "balu@gmail.com"))
    userManager.addUser(User(3, "Charan", "charan@gmail.com"))

    // Attempting to add a duplicate user
    userManager.addUser(User(2, "Balu", "balu@gmail.com"))

    // Removing a user
    userManager.removeUserById(3)

    // Attempting to remove a non-existent user
    userManager.removeUserById(5)

    // Displaying all users
    println("\nAll users:")
    userManager.getAllUsers().forEach { println(it) }

    // Finding a user by email
    val foundUser = userManager.findUserByEmail("ajay@gmail.com")
    println("\nFound user: $foundUser")
}
