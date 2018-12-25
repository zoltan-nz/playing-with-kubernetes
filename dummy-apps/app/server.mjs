import Koa from "koa";

const PORT = process.env.PORT || 3000;

const app = new Koa();

app.use(async ctx => (ctx.body = "<h1>Hello World</h1>"));
app.listen(PORT);

process.stdout.write(`App listening on port ${PORT}`);
