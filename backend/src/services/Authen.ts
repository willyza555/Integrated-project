import { User } from "@/database/models";
import type { ResultHandler } from "@/interface/handler";
import { genericError, infoResponse } from "./Handler";
import { generateJwtToken } from "@/utils";
import { SignUpPost } from "@/interface/api/User";

import bcrypt from "bcrypt";
const saltRounds = 10;

export const login = async (email: string, password: string): ResultHandler => {
	try {
		const user = await User.findOne({ email }).exec();
		if (!user) {
			return genericError("User not found", 400);
		}
		const isMatch = await bcrypt.compare(password, user.password);
		if (!isMatch) {
			return genericError("Password is incorrect", 400);
		}

		const token = generateJwtToken(user._id, user.email);

		return infoResponse(token, "Sign in success");
	} catch (e) {
		return genericError(e.message, 503);
	}
};

export const signup = async (data: SignUpPost): ResultHandler => {
	try {
		const { password, ...props } = data;
		if (password.length < 4) {
			return genericError("Password lenght must not less than 4", 400);
		}
		const user = await User.findOne({ email: props.email }).exec();
		if (user) {
			return genericError("Email already exists", 400);
		}

		// Create user
		const hashedPassword = await bcrypt.hash(password, saltRounds);
		const myUser = new User({ ...props, password: hashedPassword });
		try {
			await myUser.save();
		} catch (e) {
			return genericError(e.message, 400);
		}

		// Return token
		const token = generateJwtToken(myUser._id, myUser.email);

		return infoResponse(token, "Sign up success", 201);
	} catch (e) {
		return genericError(e.message, 503);
	}
};
