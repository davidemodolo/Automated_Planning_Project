import requests

def resolveWithAPI(domain, problem):
        data = {'domain': domain,
            'problem': problem}
        resp = requests.post('http://solver.planning.domains/solve',
                 verify=False, json=data).json()
        # return '\n'.join([act['name'] for act in resp['result']['plan']])
        return '\n'.join([act for act in resp['result']['plan']])

domain = "problem2/domain.pddl"
problem = "problem2/problem.pddl"

domain = open(domain, 'r').read()
problem = open(problem, 'r').read()

print(resolveWithAPI(domain, problem))
