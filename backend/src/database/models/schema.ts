import { Schema, Types } from "mongoose";
import User from "@/interface/models/User";
import Restaurant from "@/interface/models/Restaurant";
import Product from "@/interface/models/Product";
import Order from "@/interface/models/Order";
import OrderDetail from "@/interface/models/OrderDetail";

const validateEmail = function (email) {
	var re = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
	return re.test(email);
};

export const userSchema = new Schema<User>({
	user_id: {
		type: Types.ObjectId,
		ref: "User",
		required: [true, "User id is required"],
	},
	email: {
		type: String,
		required: [true, "Enter an email address."],
		validate: [validateEmail, "Please fill a valid email address"],
		unique: true,
	},
	password: {
		type: String,
		required: [true, "Enter a password."],
		minlength: [4, "Password must be at least 4 characters"],
	},
	tel: {
		type: String,
		required: [true, "Enter a phone number."],
		minLength: [10, "Phone number should be at least 10 characters"],
		maxlength: [10, "Phone number should be at most 10 characters"],
	},
	isRestaurant: {
		type: Boolean,
		required: [true, "Are you a restaurant?"],
		default: false,
	},
	firstname: {
		type: String,
		required: [true, "Enter your firstname"],
	},
	lastname: {
		type: String,
		required: [true, "Enter your lastname"],
	},
});

export const restaurantSchema = new Schema<Restaurant>({
	res_id: {
		type: Types.ObjectId,
		ref: "User",
		required: [true, "User id is required"],
	},
	owner_id: {
		type: String,
		unique: true,
	},
	name: {
		type: String,
	},
	address: { type: String, required: true },
	location: {
		type: {
			type: String, // Don't do `{ location: { type: String } }`
			enum: ["Point"], // 'location.type' must be 'Point'
			required: true,
		},
		coordinates: {
			type: [Number],
			required: true,
		},
	},
	isOpen: {
		type: Boolean,
		required: true,
		default: false,
	},
});

export const productSchema = new Schema<Product>({
	product_id: {
		type: Types.ObjectId,
		required: true,
	},
	res_id: {
		type: String,
		required: true,
	},
	name: {
		type: String,
		required: true,
	},
	price: {
		type: Number,
		required: true,
	},
});

export const orderSchema = new Schema<Order>({
	order_id: {
		type: Types.ObjectId,
		required: true,
	},
	customer_id: {
		type: Types.ObjectId,
		required: true,
	},
	total: {
		type: Number,
		required: true,
	},
	rider_id: {
		type: Types.ObjectId,
		required: true,
	},
});

export const orderDetailSchema = new Schema<OrderDetail>({
	order_id: {
		type: Types.ObjectId,
		required: true,
	},
	product_id: {
		type: Types.ObjectId,
		required: true,
	},
	quantity: {
		type: Number,
		required: true,
	},
});
