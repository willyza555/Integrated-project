import { ObjectId } from "mongoose";

export interface RestaurantPost {
	name: string;
	address: string;
	location: {
		type: "Point";
		coordinates: number[];
	};
}
