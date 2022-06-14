import { ObjectId } from "mongoose";

export default interface Restaurant {
	owner_id: string;
	name: string;
	address: string;
	location: {
		type: "Point";
		coordinates: number[];
	};
	isOpen: boolean;
}
