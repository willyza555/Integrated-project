import { ObjectId } from "mongoose";

export interface RestaurantPost {
	owner_id: ObjectId;
	name: string;
	address: string;
	location: {
		type: "Point";
		coordinates: [];
	};
	isOpen: boolean;
}
