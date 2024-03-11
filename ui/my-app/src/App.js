import React, { useState } from 'react';
import { BrowserRouter, Route, Switch, NavLink, Redirect ,useHistory } from 'react-router-dom';
import Home from './Home'; 

import { Department } from './Department';
import { Employee } from './Employee';
import Login from './Login'; // Importez votre composant de connexion
import Register from './Register'; // Importez votre composant d'inscription

function App() {
  const [isLoggedIn, setIsLoggedIn] = useState(false);
  const history = useHistory();
  // Fonction pour mettre à jour l'état de connexion
  const handleLogin = () => {
    setIsLoggedIn(true);
    //history.push("/");
  }

  return (
    <BrowserRouter>
      <div className="App container">
        <h3 className="d-flex justify-content-center m-3">
         
        </h3>

        <nav className="navbar navbar-expand-sm bg-light navbar-dark">
          <ul className="navbar-nav">
            {isLoggedIn && (
              <>
                <li className="nav-item- m-1">
                  <NavLink className="btn btn-light btn-outline-primary" to="/home">
                    Home
                  </NavLink>
                </li>
                <li className="nav-item- m-1">
                  <NavLink className="btn btn-light btn-outline-primary" to="/department">
                    Department
                  </NavLink>
                </li>
                <li className="nav-item- m-1">
                  <NavLink className="btn btn-light btn-outline-primary" to="/employee">
                    Employee
                  </NavLink>
                </li>
              </>
            )}
          </ul>
        </nav>
         
        <Switch>
          {/* Route pour la page d'inscription */}
          <Route path='/register' component={Register} /> 
          
          {/* Route pour la page de connexion */}
          <Route path='/login' render={() => (
            isLoggedIn ? <Redirect to="/" /> : <Login handleLogin={handleLogin} />
          )} />

          {/* Routes protégées */}
          <Route path='/home' component={Home} />
          <Route path='/department' component={Department} />
          <Route path='/employee' component={Employee} />
          
          {/* Rediriger vers la page de connexion si aucune route ne correspond */}
          <Route render={() => <Redirect to="/login" />} />
        </Switch>
      </div>
    </BrowserRouter>
  );
}




export default App;
