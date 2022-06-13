import { ObjectId } from "mongoose";

export default interface User {
	user_id: ObjectId;
	firstname: string;
	lastname: string;
	password: string;
	email: string;
	tel: string;
	isRestaurant: boolean;
}
