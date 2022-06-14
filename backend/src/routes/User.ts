import { SignInPost, SignUpPost } from "@/interface/api/User";
import { signup, login } from "@/services/Authen";
import { responseHandler } from "@/services/Handler";
import express from "express";

const userRoute = express.Router();

userRoute.post("/signup", async (req, res) => {
	const data: SignUpPost = req.body;
	return responseHandler(res, await signup(data));
});

userRoute.post("/signin", async (req, res) => {
	const { email, password }: SignInPost = req.body;
	return responseHandler(res, await login(email, password));
});

export default userRoute;
