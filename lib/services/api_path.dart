class APIPath {
  static String userPath({required String id}) => 'users/$id';
  static String mealPlanPath({required String id}) => 'users/$id/usermealplan';
  static String addNewMealPlanPath({required String id, required String mealPlan}) => 'users/$id/usermealplan/$mealPlan';
  static String userSavedMeal({required String id, required String docId}) => 'users/$id/savedmeal/$docId';
  static String userSavedMeals({required String id}) => 'users/$id/savedmeal';
}