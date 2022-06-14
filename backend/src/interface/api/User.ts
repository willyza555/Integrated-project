export interface SignInPost {
	email: string;
	password: string;
}

export interface SignUpPost {
	email: string;
	password: string;
	firstname: string;
	lastname: string;
	isRestaurant: boolean;
	tel: string;
}
