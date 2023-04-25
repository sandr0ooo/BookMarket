package org.BookMarket.util;

public class Validators {
    public static boolean validatePassword(String password) {
        if (!password.matches(".*\\d.*")) {
            return false;
        }

        if (!password.matches(".*[a-z].*")) {
            return false;
        }

        if (!password.matches(".*[A-Z].*")) {
            return false;
        }

        return true;
    }
    public static boolean validateUsername(String username) {
        if (!username.matches("[A-Za-z0-9_]+")) {
            return false;
        }

        // If all checks pass, return true
        return true;
    }
}
