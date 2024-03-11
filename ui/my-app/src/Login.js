import React, { useRef, useState } from 'react';
import { Link, useHistory,useLocation } from 'react-router-dom';
import { TextField, Button, Typography, Container, Grid } from '@mui/material';

const Login = () => {
    const history = useHistory();
    const location = useLocation();
    const from = location.state?.from || { pathname: "/home" };

    const userRef = useRef();
    const passwordRef = useRef();
    const errRef = useRef();

    const [errMsg, setErrMsg] = useState('');

    const handleSubmit = async (e) => {
        e.preventDefault();

        const email = userRef.current.value;
        const password = passwordRef.current.value;

        try {
            const response = await fetch('http://127.0.0.1:8000/login/', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ email, password })
            });

            if (!response.ok) {
                throw new Error('Login failed');
            }

            const data = await response.json();
            console.log(data.token); // Faites quelque chose avec la réponse si nécessaire
            history.replace(from); // Rediriger vers la page précédente ou la page par défaut après la connexion réussie
        } catch (err) {
            console.error('Login failed:', err);
            setErrMsg('Login Failed');
            errRef.current.focus();
        }
    }

    return (
        <Container component="main" maxWidth="xs">
            <div>
                <Typography component="h1" variant="h5">
                    Sign In
                </Typography>
                <br></br>
                <form onSubmit={handleSubmit}>
                    <Grid container spacing={2}>
                        <Grid item xs={12}>
                            <TextField
                                variant="outlined"
                                required
                                fullWidth
                                id="email"
                                label="Email Address"
                                inputRef={userRef}
                                autoComplete="email"
                            />
                        </Grid>
                        <Grid item xs={12}>
                            <TextField
                                variant="outlined"
                                required
                                fullWidth
                                id="password"
                                label="Password"
                                type="password"
                                inputRef={passwordRef}
                                autoComplete="current-password"
                            />
                        </Grid>
                    </Grid>
                    <Button
                        type="submit"
                        fullWidth
                        variant="contained"
                        color="primary"
                    >
                        Sign In
                    </Button>
                </form>
                <Typography variant="body2" color="error">
                    {errMsg}
                </Typography>
                <Grid container justifyContent="flex-end">
                    <Grid item>
                        <Link to="/Register" variant="body2">
                            {"Don't have an account? Sign Up"}
                        </Link>
                    </Grid>
                </Grid>
            </div>
        </Container>
    )
}

export default Login;
