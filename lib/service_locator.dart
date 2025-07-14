import 'package:get_it/get_it.dart';

import 'core/local_storage/secure_storage.dart';
import 'core/network/dio.dart';
import 'features/auth/data/datasource/auth_local_data_source.dart';
import 'features/auth/data/datasource/auth_remote_data_source.dart';
import 'features/auth/data/repository/auth_repository_impl.dart';
import 'features/auth/domain/repository/auth_repository.dart';
import 'features/auth/domain/usecases/current_user.dart';
import 'features/auth/domain/usecases/user_login.dart';
import 'features/auth/domain/usecases/user_logout.dart';
import 'features/auth/domain/usecases/user_register.dart';
import 'features/auth/domain/usecases/user_upload_photo.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/home/data/datasource/home_remote_data_source.dart';
import 'features/home/data/repository/home_repository_impl.dart';
import 'features/home/domain/repository/home_repository.dart';
import 'features/home/domain/usecase/favorite_movie.dart';
import 'features/home/domain/usecase/fecth_movie_list.dart';
import 'features/home/domain/usecase/fetch_favorite_list.dart';
import 'features/home/presentation/bloc/home_bloc.dart';
import 'shared/cubits/app_user/app_user_cubit.dart';

final serviceLocator = GetIt.instance;

Future<void> initServiceLocator() async {
  _initAuth();
  serviceLocator.registerSingleton<DioClient>(DioClient());
  serviceLocator.registerSingleton<StorageClient>(StorageClient());
  serviceLocator.registerLazySingleton<AppUserCubit>(() => AppUserCubit());
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(serviceLocator<DioClient>()));
  serviceLocator.registerFactory<AuthLocalDataSource>(() => AuthLocalDataSourceImpl(serviceLocator<StorageClient>()));
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDataSource: serviceLocator<AuthRemoteDataSource>(),
      authLocalDataSource: serviceLocator<AuthLocalDataSource>(),
    ),
  );
  serviceLocator.registerFactory<UserRegister>(() => UserRegister(serviceLocator<AuthRepository>()));
  serviceLocator.registerFactory<UserLogin>(() => UserLogin(serviceLocator<AuthRepository>()));
  serviceLocator.registerFactory<UserLogouUseCase>(() => UserLogouUseCase(serviceLocator<AuthRepository>()));
  serviceLocator.registerFactory<CurrentUser>(() => CurrentUser(serviceLocator<AuthRepository>()));
  serviceLocator.registerFactory<UserUploadPhoto>(() => UserUploadPhoto(serviceLocator<AuthRepository>()));
  serviceLocator.registerLazySingleton<AuthBloc>(
    () => AuthBloc(
      userRegister: serviceLocator<UserRegister>(),
      userLogin: serviceLocator<UserLogin>(),
      currentUser: serviceLocator<CurrentUser>(),
      appUserCubit: serviceLocator<AppUserCubit>(),
      userUploadPhoto: serviceLocator<UserUploadPhoto>(),
    ),
  );

  //HOME
  serviceLocator.registerFactory<HomeRemoteDataSource>(() => HomeRemoteDataSourceImpl(serviceLocator<DioClient>()));
  serviceLocator.registerFactory<HomeRepository>(
    () => HomeRepositoryImpl(
      authLocalDataSource: serviceLocator<AuthLocalDataSource>(),
      homeRemoteDataSource: serviceLocator<HomeRemoteDataSource>(),
    ),
  );
  serviceLocator.registerFactory<FecthMovieList>(() => FecthMovieList(serviceLocator<HomeRepository>()));
  serviceLocator.registerFactory<FetchFavoriteList>(() => FetchFavoriteList(serviceLocator<HomeRepository>()));
  serviceLocator.registerFactory<FavoriteMovie>(() => FavoriteMovie(serviceLocator<HomeRepository>()));
  serviceLocator.registerLazySingleton<HomeBloc>(
    () => HomeBloc(
      favoriteMovie: serviceLocator<FavoriteMovie>(),
      fecthMovieList: serviceLocator<FecthMovieList>(),
      fetchFavoriteList: serviceLocator<FetchFavoriteList>(),
    ),
  );
}
