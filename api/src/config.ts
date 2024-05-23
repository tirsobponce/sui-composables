import { z } from "zod";

const config = z.object({
  MNEMONICS: z.string(),
});

export const env = config.parse(process.env);
