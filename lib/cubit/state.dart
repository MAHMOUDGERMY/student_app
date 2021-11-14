abstract class HomeState {}

class InitialState extends HomeState {}

class changeNavState extends HomeState {}

class PostImagePickedSuccessState extends HomeState {}

class PostImagePickedErrorState extends HomeState {}

class PostAddLoadingState extends HomeState {}

class PostAddSuccessState extends HomeState {}

class PostAddErrorsState extends HomeState {}

class RemovePostImage extends HomeState {}

class GetPostsSuccessState extends HomeState {}

class GetPostsLoadingState extends HomeState {}

class GetPostsErrorState extends HomeState {}

class GetUserState extends HomeState {}

class userLogin extends HomeState {}

class userLogout extends HomeState {}

class getFilesError extends HomeState {}

class getFilesSuccess extends HomeState {}

class getFilesLoading extends HomeState {}
