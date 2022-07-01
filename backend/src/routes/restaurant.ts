import { RestaurantPost } from "@/interface/api/Restaurant";
import { responseHandler } from "@/services/Handler";
import {
	createRestautant,
	deleteRestaurant,
	readRestautant,
	updateRestaurant,
} from "@/services/Restaurant";
import express from "express";

const restaurantRoute = express.Router();

restaurantRoute.post("/create", async (req, res) => {
	const data: RestaurantPost = req.body;
	return responseHandler(res, await createRestautant(req, data));
});

restaurantRoute.get("/", async (req, res) => {
	return responseHandler(res, await readRestautant(req));
});

restaurantRoute.delete("/", async (req, res) => {
	return responseHandler(res, await deleteRestaurant(req));
});

restaurantRoute.patch("/close", async (req, res) => {
	return responseHandler(res, await updateRestaurant(req));
})

export default restaurantRoute;
