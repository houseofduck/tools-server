import env from "env";

export const isEmailEnabled = () => !!env.RESEND_API_KEY && !!env.EMAIL_FROM
