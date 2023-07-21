import app from './app';

/**
 * porta disponivel ou porta 3333
 */
const port = process.env.PORT ?? 3333
app.listen(port);

