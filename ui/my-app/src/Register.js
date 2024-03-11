import { useRef, useState, useEffect } from "react";
import { faCheck, faTimes, faInfoCircle } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { Link } from "react-router-dom";



const USER_REGEX = /^[A-z][A-z0-9-_]{3,23}$/;
const PWD_REGEX = /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%]).{8,24}$/;
const REGISTER_URL = '/api/register';

const Register = () => {
    const userRef = useRef();
    const emailRef = useRef();
    const pwdRef = useRef();
    const errRef = useRef();

    const [user, setUser] = useState('');
    const [email, setEmail] = useState('');
    const [validName, setValidName] = useState(false);
    const [userFocus, setUserFocus] = useState(false);

    const [pwd, setPwd] = useState('');
    const [validPwd, setValidPwd] = useState(false);
    const [pwdFocus, setPwdFocus] = useState(false);

    const [errMsg, setErrMsg] = useState('');
    const [success, setSuccess] = useState(false);

    useEffect(() => {
        userRef.current.focus();
    }, [])

    useEffect(() => {
        setValidName(USER_REGEX.test(user));
    }, [user])

    useEffect(() => {
        setValidPwd(PWD_REGEX.test(pwd));
    }, [pwd])

    useEffect(() => {
        setErrMsg('');
    }, [user, pwd])

    const handleSubmit = async (e) => {
        e.preventDefault();

        const v1 = USER_REGEX.test(user);
        const v2 = PWD_REGEX.test(pwd);
        if (!v1 || !v2) {
            setErrMsg("Invalid Entry");
            return;
        }

        try {
            setSuccess(true);
            setUser('');
            setEmail('');
            setPwd('');
        } catch (err) {
            setErrMsg('Registration Failed');
            errRef.current.focus();
        }
    }

    return (
        <div className="container">
            <div className="row justify-content-center">
                <div className="col-md-6">
                    <div className="card">
                        <div className="card-body">
                            {success ? (
                                <div className="text-center">
                                    <h1>Success!</h1>
                                    <p>
                                        <Link to="/">Sign In</Link>
                                    </p>
                                </div>
                            ) : (
                                <form onSubmit={handleSubmit}>
                                    <h1 className="mb-4 text-center">Register</h1>

                                    <p ref={errRef} className={errMsg ? "errmsg" : "offscreen"} aria-live="assertive">{errMsg}</p>

                                    <div className="mb-3">
                                        <label htmlFor="username" className="form-label">Username:</label>
                                        <input
                                            type="text"
                                            id="username"
                                            ref={userRef}
                                            autoComplete="off"
                                            className="form-control"
                                            onChange={(e) => setUser(e.target.value)}
                                            value={user}
                                            required
                                        />
                                        <FontAwesomeIcon icon={faCheck} className={validName ? "valid" : "hide"} />
<FontAwesomeIcon icon={faTimes} className={validName || !user ? "hide" : "invalid"} />
                                        <p className={userFocus && user && !validName ? "instructions" : "offscreen"}>
                                            <FontAwesomeIcon icon={faInfoCircle} />
                                            4 to 24 characters. Must begin with a letter.
                                        </p>
                                    </div>

                                    <div className="mb-3">
                                        <label htmlFor="email" className="form-label">Email:</label>
                                        <input
                                            type="email"
                                            id="email"
                                            ref={emailRef}
                                            autoComplete="off"
                                            className="form-control"
                                            onChange={(e) => setEmail(e.target.value)}
                                            value={email}
                                            required
                                        />
                                    </div>

                                    <div className="mb-3">
                                        <label htmlFor="password" className="form-label">Password:</label>
                                        <input
                                            type="password"
                                            id="password"
                                            ref={pwdRef}
                                            className="form-control"
                                            onChange={(e) => setPwd(e.target.value)}
                                            value={pwd}
                                            required
                                        />
                                        <FontAwesomeIcon icon={faCheck} className={validPwd ? "valid" : "hide"} />
                                        <FontAwesomeIcon icon={faTimes} className={validPwd || !pwd ? "hide" : "invalid"} />
                                        <p className={pwdFocus && !validPwd ? "instructions" : "offscreen"}>
                                            <FontAwesomeIcon icon={faInfoCircle} />
                                            8 to 24 characters. Must include uppercase and lowercase letters, a number and a special character.
                                        </p>
                                    </div>

                                    <div className="text-center">
                                        <button type="submit" className="btn btn-primary" disabled={!validName || !validPwd}>Sign Up</button>
                                    </div>
                                </form>
                            )}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    )
}

export default Register;
