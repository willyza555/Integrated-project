import { ObjectId } from "mongoose";

export default interface Restaurant {
	res_id: ObjectId;
	owner_id: string;
	name: string;
	address: string;
	location: {
		type: "Point";
		coordinates: number[];
	};
	isOpen: boolean;
}
