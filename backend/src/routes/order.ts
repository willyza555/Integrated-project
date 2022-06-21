import { CreateOrderPost, OrderUpdate } from "@/interface/api/Order";
import { responseHandler } from "@/services/Handler";
import {
	CreateOrder,
	DeleteOrder,
	GetOrder,
	GetOrders,
	OrderDone,
	UpdateOrder,
} from "@/services/Order";
import express from "express";

const orderRoute = express.Router();

orderRoute.post("/", async (req, res) => {
	const data: CreateOrderPost = req.body;
	return responseHandler(res, await CreateOrder(req, data));
});

orderRoute.delete("/delete/:order_id", async (req, res) => {
	return responseHandler(res, await DeleteOrder(req));
});

orderRoute.get("/", async (req, res) => {
	return responseHandler(res, await GetOrders(req));
});

orderRoute.get("/:order_id", async (req, res) => {
	return responseHandler(res, await GetOrder(req));
});

orderRoute.patch("/update", async (req, res) => {
	const data: OrderUpdate = req.body;
	return responseHandler(res, await UpdateOrder(req, data));
});

orderRoute.patch("/done/:order_id", async (req, res) => {
	return responseHandler(res, await OrderDone(req));
});

export default orderRoute;
