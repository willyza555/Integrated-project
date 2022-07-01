import { ObjectId } from "mongoose";

export default interface User {
	firstname: string;
	lastname: string;
	password: string;
	email: string;
	tel: string;
	isRestaurant: boolean;
	picture_url: string;
}
