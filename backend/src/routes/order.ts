import { CreateOrderPost } from "@/interface/api/Order";
import { responseHandler } from "@/services/Handler";
import { CreateOrder, DeleteOrder } from "@/services/Order";
import express from "express";

const orderRoute = express.Router();

orderRoute.post("/createorder", async (req, res) => {
	const data: CreateOrderPost = req.body;
	return responseHandler(res, await CreateOrder(req, data));
});

orderRoute.delete("/:order_id", async (req, res) => {
    return responseHandler(res, await DeleteOrder(req));
});
export default orderRoute;