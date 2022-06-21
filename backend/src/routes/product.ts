import { ProductPost } from "@/interface/api/Product";
import { responseHandler } from "@/services/Handler";
import {
	AddProduct,
	DeleteProduct,
	GetProductById,
	GetProducts,
	ProductSoldOut,
	UpdateProduct,
} from "@/services/Product";
import express from "express";
import { Types } from "mongoose";

const productRoute = express.Router();

productRoute.post("/add", async (req, res) => {
	const data: ProductPost = req.body;
	return responseHandler(res, await AddProduct(req, data));
});

productRoute.patch("/:id", async (req, res) => {
	const { id } = req.params;
	const product_id = new Types.ObjectId(id);
	const data: ProductPost = req.body;
	return responseHandler(res, await UpdateProduct(req, data, product_id));
});

productRoute.get("/", async (req, res) => {
	return responseHandler(res, await GetProducts(req));
});

productRoute.get("/:id", async (req, res) => {
	const { id } = req.params;
	const product_id = new Types.ObjectId(id);
	return responseHandler(res, await GetProductById(req, product_id));
});

productRoute.delete("/:id", async (req, res) => {
	const { id } = req.params;
	const product_id = new Types.ObjectId(id);
	return responseHandler(res, await DeleteProduct(req, product_id));
});

productRoute.patch("/done", async (req, res) => {
	const product_id = new Types.ObjectId(req.body.product_id);
	return responseHandler(res, await ProductSoldOut(req, product_id));
});

export default productRoute;
