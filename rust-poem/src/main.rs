#![allow(dead_code)]
#![allow(unused_variables)]

use dotenvy::dotenv;

use poem::{
    listener::TcpListener, web::Data, EndpointExt,
    Result, Route, Server,
};
use poem_openapi::{
    payload::{Json, PlainText},
    Object, OpenApi, OpenApiService,
};

use sqlx::PgPool;

#[derive(Object)]
struct User {
    id: i32,
    name: String,
    email: String,
}

type UserResponse = Result<Json<Vec<User>>>;

struct UsersApi;

#[OpenApi]
impl UsersApi {
    #[oai(path = "/users", method = "post")]
    async fn create(
        &self,
        pool: Data<&PgPool>,
        name: PlainText<String>,
        email: PlainText<String>
    ) -> Result<Json<u64>> {
        let row = sqlx::query!(
	        "insert into users (name, email) values ($1, $2)",
            name.0,
            email.0
		)
            
		.execute(pool.0)
		.await
        .expect("Failed to create user");

        Ok(Json(row.rows_affected()))
    }

    #[oai(path = "/users", method = "get")]
    async fn get_all(&self, pool: Data<&PgPool>
    ) -> UserResponse {
        let users = sqlx::query_as!(
	        User, 
	        "SELECT * FROM users"
	    )
		.fetch_all(pool.0)
		.await
		.unwrap();
        
        Ok(Json(users))
    }
}

#[tokio::main]
async fn main() 
	-> Result<(), Box<dyn std::error::Error>> {
    dotenv().ok();
    let url = std::env::var("DATABASE_URL").expect("DATABASE_URL must be set.");
    let pool = 
	    PgPool::connect(&url).await?;
    let api_service = 
	    OpenApiService::new(UsersApi, "Users", "1.0.0")
	    .server("http://localhost:3003");
    let ui = api_service.openapi_explorer();
    let route = Route::new()
        .nest("/", api_service)
        .nest("/ui", ui)
        .data(pool);
    let addr: std::net::SocketAddr = std::net::SocketAddr::from(([0, 0, 0, 0], 3003));
    println!("listening on {}", addr);

    Server::new(TcpListener::bind("0.0.0.0:3003"))
        .run(route).await?;
    Ok(())
}
